package com.byzx.authority.vo;

import java.util.Date;

public class Invoice {
	 //主键id
    private Integer invId;
    //订单id
    private Integer orderId;
    //开票抬头
    private String title;
    //开票内容
    private String context;
    //开票内容
    private String state;
    //创建时间
    private Date createTime;
    //开票金额
    private Float money;

    public Integer getInvId() {
        return invId;
    }

    public void setInvId(Integer invId) {
        this.invId = invId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context == null ? null : context.trim();
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Float getMoney() {
        return money;
    }

    public void setMoney(Float money) {
        this.money = money;
    }
}