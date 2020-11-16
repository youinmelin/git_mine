<template>
  <div class="video-item" @click="$router.push({path:'/productMain',query:{id:content.id}})">
    <div class="top" :style="{height: height + 'px', width: width + 'px'}">
      <div class="play">
        <svg-icon class="icon" icon-class="play"/>
      </div>
      <img :src="content.videoImgUrl"/>
      <span class="title">{{ content.name }}</span>
      <div class="cover">
        <div class="inner">
          <span class="item">
            <svg-icon class="like" icon-class="star"/>
            {{ content.id }}
          </span>
          <span class="time">{{ content.strDuration }}</span>
        </div>
      </div>
    </div>
    <div v-if="showBottom" class="bottom" :style="{width: width + 'px'}">
      <div class="name">产品名称（机器人）</div>
      <div class="operate">
        <a class="edit">编辑</a>
        <a>查看详情</a>
        <img class="del" src="../../assets/icons/delete.png"/>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    showBottom: {
      type: Boolean,
      default: false
    },
    content: {
      type: Object,
      default: {}
    },
    width: {
      type: Number,
      default: 213
    },
    height: {
      type: Number,
      default: 156
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

    .play {
      position: absolute;
      width: 40px;
      height: 40px;
      background: rgba(255, 255, 255, .6);
      border-radius: 50%;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);

      .icon {
        position: absolute;
        color: #ffffff;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
      }
    }
  }

  .title {
    position: absolute;
    top: 5px;
    left: 6px;
    width: 70px;
    height: 20px;
    border-radius: 15px;
    background: rgba(0, 0, 0, .5);
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
      bottom: 5px;
      width: 100%;
    }

    .item {
      font-size: 12px;
      color: #ffffff;
      margin-left: 5px;
    }

    .time {
      position: absolute;
      right: 5px;
      bottom: 0;
      font-size: 12px;
      color: #ffffff;
    }

    .like {
      font-size: 15px;
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
  }
}
</style>
