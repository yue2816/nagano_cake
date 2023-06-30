class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def check
    @order = Order.new(order_params)
    @order.shipping_postal_code = current_customer.postal_code
    @order.shipping_address = current_customer.address
    @order.shipping_name = current_customer.last_name + current_customer.first_name
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.subtotal }
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item| #カートの商品を1つずつ取り出しループ
      @order_item = OrderItem.new #初期化宣言
      @order_item.item_id = cart_item.item_id #商品idを注文商品idに代入
      @order_item.amount = cart_item.amount #商品の個数を注文商品の個数に代入
      @order_item.tax_price = cart_item.item.with_tax_price #消費税込みに計算して代入
      @order_item.order_id =  @order.id #注文商品に注文idを紐付け
      @order_item.save #注文商品を保存
    end #ループ終わり

    current_customer.cart_items.destroy_all #カートの中身を削除
    redirect_to thanks_path
  end

  def thanks
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
  end

  private
    def order_params
        params.require(:order).permit(:shipping_postal_code, :shipping_address, :shipping_name, :payment, :shipping_fee, :amount_billed, :customer_id)
    end
end
