package com.forgetfulr.common.enums;

/**
 * 用户redis sortedSet传参
 *
 * @author caorui
 * @date 2018/1/8
 */
public class TupleDO {

    private double score;

    private String value;

    public TupleDO() {

    }

    public TupleDO(double score, String value) {
        this.score = score;
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public double getScore() {

        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    @Override
    public String toString() {
        return "TupleDO{" +
                "score='" + score + '\'' +
                ", value='" + value + '\'' +
                '}';
    }
}
