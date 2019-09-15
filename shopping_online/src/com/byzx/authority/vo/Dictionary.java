package com.byzx.authority.vo;

public class Dictionary {
    private Integer dicId;

    private Integer spcId;

    private String dicName;

    private String state;

    private Integer rank;

    public Integer getDicId() {
        return dicId;
    }

    public void setDicId(Integer dicId) {
        this.dicId = dicId;
    }

    public Integer getSpcId() {
        return spcId;
    }

    public void setSpcId(Integer spcId) {
        this.spcId = spcId;
    }

    public String getDicName() {
        return dicName;
    }

    public void setDicName(String dicName) {
        this.dicName = dicName == null ? null : dicName.trim();
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public Integer getRank() {
        return rank;
    }

    public void setRank(Integer rank) {
        this.rank = rank;
    }

	@Override
	public String toString() {
		return "Dictionary [dicId=" + dicId + ", spcId=" + spcId + ", dicName=" + dicName + ", state=" + state
				+ ", rank=" + rank + "]";
	}



    






}