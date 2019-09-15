package com.byzx.authority.vo;

public class ReturnApp {
	//主键id
    private Integer returnId;
    //订单id
    private Integer orderId;
    //退货退款id
    private String returnNum;
    //退款金额
    private Float returnMoney;
    //Skuid
    private Integer skuId;
    //退货商品id
    private Integer proId;
    //退货退款
    private String state;
    //审核状态
    private String auditState;
    //备注
    private String remark;

    public Integer getReturnId() {
        return returnId;
    }

    public void setReturnId(Integer returnId) {
        this.returnId = returnId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getReturnNum() {
        return returnNum;
    }

    public void setReturnNum(String returnNum) {
        this.returnNum = returnNum == null ? null : returnNum.trim();
    }

    public Float getReturnMoney() {
        return returnMoney;
    }

    public void setReturnMoney(Float returnMoney) {
        this.returnMoney = returnMoney;
    }

    public Integer getSkuId() {
        return skuId;
    }

    public void setSkuId(Integer skuId) {
        this.skuId = skuId;
    }

    public Integer getProId() {
        return proId;
    }

    public void setProId(Integer proId) {
        this.proId = proId;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public String getAuditState() {
        return auditState;
    }

    public void setAuditState(String auditState) {
        this.auditState = auditState == null ? null : auditState.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }
}