<template>
  <div
    class="live-item"
    :style="{height: height + 'px', width: width + 'px'}"
  >
    <div class="top" @click="$router.push({path:'/videoLiveMain',query:{id:content.id}})">
      <img class="icon" src="../../assets/icons/live-icon.png"/>
      <img class="cover" :src="content.videoImgUrl"/>
      <span class="lick-num">
        <svg-icon class="like" icon-class="star"/>
        {{ content.id }}
      </span>
    </div>
    <div class="bottom">
      <div class="title">{{ content.title }}</div>
      <div class="price">¥{{ content.price }}</div>
      <div class="btn">
        <div class="try">试用</div>
        <div class="buy" @click="jumpToUrl(content.buyUrl)">购买</div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    content: {
      type: Object,
      default: {}
    },
    width: {
      type: Number,
      default: 215
    },
    height: {
      type: Number,
      default: 394
    }
  },
  methods: {
    jumpToUrl(url) {
      // jumpToUrl(content.liveLink)
      window.open(url, '_blank')
    }
  }
}
</script>

<style lang="scss" scoped>
.live-item {
  position: relative;
  display: inline-block;

  .top {
    position: relative;
    width: 100%;
    height: 273px;

    .cover {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .icon {
      position: absolute;
      top: 7px;
      left: 2px;
    }

    .lick-num {
      position: absolute;
      bottom: 5px;
      right: 5px;
      color: #ffffff;
      font-size: 12px;
    }
  }

  .bottom {
    height: 121px;
    padding-top: 12px;
    text-align: center;
    background: #EDEDED;

    .title {
      width: 100%;
      text-align: center;
      color: #474747;
      font-size: 14px;
    }

    .price {
      font-size: 18px;
      color: #cc151d;
      font-weight: bold;
      margin-top: 10px;
    }

    .btn {
      width: 100%;
      margin-top: 10px;

      .try, .buy {
        display: inline-block;
        font-size: 12px;
        border-radius: 3px;
        vertical-align: middle;
        cursor: pointer;
      }

      .try {
        width: 67px;
        height: 23px;
        border: 1px solid #cc151d;
        color: #cc151d;
        line-height: 23px;
      }

      .buy {
        width: 68px;
        height: 23px;
        background: #cc151d;
        color: #ffffff;
        text-align: center;
        line-height: 23px;
        margin-left: 16px;
      }
    }
  }
}
</style>
