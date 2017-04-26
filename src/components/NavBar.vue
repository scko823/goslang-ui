<template>
  <div class="nav-menu">
    <h2>Rooms</h2>
    <ul>
      <li>
        <router-link :to="{path: '/add-room'}">Make a new room</router-link>
      </li>
      <li v-for="room in rooms">
        <router-link :to="{path: '/rooms/'+room}">Go to {{room}}</router-link>
      </li>
    </ul>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'navBar',
  data () {
    return {
      rooms: ['main']
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}
</style>
