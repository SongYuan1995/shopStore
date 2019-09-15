package com.byzx.authority.vo;

import java.util.Date;

public class ProComment {
    private Integer commId;

    private Integer proId;

    private String proPic;

    private String context;

    private Integer createBy;

    private Integer level;

    private String replyContext;

    private Integer replyer;

    private Date createTime;

    public Integer getCommId() {
        return commId;
    }

    public void setCommId(Integer commId) {
        this.commId = commId;
    }

    public Integer getProId() {
        return proId;
    }

    public void setProId(Integer proId) {
        this.proId = proId;
    }

    public String getProPic() {
        return proPic;
    }

    public void setProPic(String proPic) {
        this.proPic = proPic == null ? null : proPic.trim();
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context == null ? null : context.trim();
    }

    public Integer getCreateBy() {
        return createBy;
    }

    public void setCreateBy(Integer createBy) {
        this.createBy = createBy;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getReplyContext() {
        return replyContext;
    }

    public void setReplyContext(String replyContext) {
        this.replyContext = replyContext == null ? null : replyContext.trim();
    }

    public Integer getReplyer() {
        return replyer;
    }

    public void setReplyer(Integer replyer) {
        this.replyer = replyer;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}