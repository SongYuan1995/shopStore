package com.byzx.authority.vo;


public class OrderInfo {
	private Integer orderId;//订单ID

    private String orderNum;//订单号

    private Integer storeId;//店铺ID

    private Integer addrId;//地址ID

    private Float totalMoney;//金额

    private String payWay;//支付方式

    private String orderState;//订单状态

    private String cartState;//购物车状态

    private String createTime;//创建时间

    private Integer userId;//下单用户

    private MemberInfo memberInfo;  //封装的会员表
    
    private Invoice invoice;//封装的订单信息
    
    
    
    
    

    public Integer getOrderId() {
        return orderId;
    }

    public MemberInfo getMemberInfo() {
		return memberInfo;
	}

	public void setMemberInfo(MemberInfo memberInfo) {
		this.memberInfo = memberInfo;
	}

	public Invoice getInvoice() {
		return invoice;
	}

	public void setInvoice(Invoice invoice) {
		this.invoice = invoice;
	}

	public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum == null ? null : orderNum.trim();
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public Integer getAddrId() {
        return addrId;
    }

    public void setAddrId(Integer addrId) {
        this.addrId = addrId;
    }

    public Float getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(Float totalMoney) {
        this.totalMoney = totalMoney;
    }

    public String getPayWay() {
        return payWay;
    }

    public void setPayWay(String payWay) {
        this.payWay = payWay == null ? null : payWay.trim();
    }

    public String getOrderState() {
        return orderState;
    }

    public void setOrderState(String orderState) {
        this.orderState = orderState == null ? null : orderState.trim();
    }

    public String getCartState() {
        return cartState;
    }

    public void setCartState(String cartState) {
        this.cartState = cartState == null ? null : cartState.trim();
    }

   

    public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
}