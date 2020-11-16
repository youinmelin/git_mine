<template>
  <div id="app">
    <!-- <div id="nav">
      <router-link to="/">Home</router-link> |
      <router-link to="/about">About</router-link>
    </div> -->
    <router-view/>

  </div>
</template>
<script>

export default {
  components: {}
}
</script>
<style lang="scss">
body {
  margin: 0;
}

* {
  box-sizing: border-box;
}

a, button, input[type=button], .curpp {
  cursor: pointer;
}

input {
  outline: none;
  border: none;
}
</style>
