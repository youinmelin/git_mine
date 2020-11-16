<template>
  <div class="video-item">
    <div
      class="top"
      :style="{height: height + 'px', width: width + 'px'}"
      @click="$router.push({path:'/productMain',query:{id:content.id}})">
      <img :src="content.videoImgUrl"/>
      <span class="title" v-if="content.title">{{ content.title }}</span>
      <div class="cover">
        <div class="inner">
          <span class="item">
            <img class="play" src="../../assets/icons/play.png"/>
            {{ content.playNum }}
          </span>
          <span class="item">
            <img class="like" src="../../assets/icons/like.png"/>
            {{ content.collectionNum }}
          </span>
          <span class="time">{{ content.strDuration }}</span>
        </div>
      </div>
    </div>
    <template v-if="showBottom">
      <div v-if="bottomStyle === 1" class="bottom" :style="{width: width + 'px'}">
        <div class="name">{{ content.name }}</div>
        <div class="operate">
          <a class="edit">编辑</a>
          <a>查看详情</a>
          <img class="del" src="../../assets/icons/delete.png"/>
        </div>
      </div>
      <div v-else-if="bottomStyle === 2" class="bottom style2" :style="{width: width + 'px'}">
        <div class="name">
          {{ content.name.slice(0, 10) }}
        </div>
        <div class="operate">
          <span class="price">¥<span class="num">{{ content.price }}</span></span>
          <div class="icons">
            <svg-icon class="like" icon-class="heart"/>
            <svg-icon class="share" icon-class="share"/>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
export default {
  props: {
    // 是否展示底部
    showBottom: {
      type: Boolean,
      default: false
    },
    // 底部样式，默认1
    bottomStyle: {
      type: Number,
      default: 1
    },
    content: {
      type: Object,
      default: {}
    },
    width: {
      type: Number,
      default: 210
    },
    height: {
      type: Number,
      default: 118
    }
  }
}
</script>

<style lang="scss" scoped>
.video-item {
  position: relative;
  display: inline-block;

  .top {
    position: relative;

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  }

  .title {
    position: absolute;
    top: 10px;
    left: 10px;
    width: 70px;
    height: 20px;
    border-radius: 15px;
    background: rgba(0, 0, 0, .65);
    font-size: 14px;
    color: #ffffff;
    text-align: center;
    line-height: 20px;
  }

  .cover {
    position: absolute;
    width: 100%;
    height: 59px;
    background: linear-gradient(to bottom, transparent, rgba(0, 0, 0, .4));
    bottom: 0;

    .inner {
      position: absolute;
      bottom: 9px;
      width: 100%;
    }

    .item {
      font-size: 12px;
      color: #ffffff;
      margin-left: 10px;
    }

    .time {
      position: absolute;
      right: 10px;
      bottom: 0;
      font-size: 12px;
      color: #ffffff;
    }

    .play {
      width: 9px;
      height: 12px;
      vertical-align: middle;
    }

    .like {
      width: 14px;
      height: 13px;
      vertical-align: middle;
    }
  }

  .bottom {
    padding: 16px 11px 16px 14px;
    border: 1px solid #EEEEEE;

    .name {
      color: #000000;
      font-size: 16px;
    }

    .operate {
      color: #388CED;
      font-size: 14px;
      margin-top: 16px;

      a {
        position: relative;
        margin-right: 30px;
        cursor: pointer;
      }

      .edit::after {
        cursor: default;
        position: absolute;
        bottom: 2px;
        right: -18px;
        content: '';
        width: 1px;
        height: 10px;
        background: #EEEEEE;
      }

      .del {
        float: right;
        width: 12px;
        height: 12px;
        cursor: pointer;
        margin-top: 4px;
      }
    }

    .el-icon-star-on {
      color: #FF9500;
    }

    .price {
      font-size: 12px;
      color: #000000;

      .num {
        font-size: 16px;
        color: #FF5040;
      }
    }
  }

  .style2 .operate {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 14px;

    .icons {
      color: #9C9C9C;

      .like {
        margin-right: 16px;
      }
    }
  }
}
</style>
