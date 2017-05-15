<template>
  <div class="nav-menu">
    <h2>Rooms</h2>
    <ul>
      <li>
        <router-link :to="{path: '/add-room'}">Make a new room</router-link>
      </li>
      <li v-for="room in rooms">
        <router-link :to="{path: '/room/'+room}">Go to {{room}}</router-link>
      </li>
    </ul>
    <router-view></router-view>
  </div>
</template>

<script>
import {wsPrefix} from '../utils/config.js'
window.roomsListener = new WebSocket(wsPrefix()+"/ws/rooms-listener")

export default {
  name: 'navBar',
  data () {
    return {
      rooms: ['main']
    }
  },
  mounted: function(){
    const self = this
    roomsListener.onmessage = function(evt){
      let roomEvent = JSON.parse(event.data)
      if (roomEvent.type === 'add'){
        self.rooms = self.rooms.concat([roomEvent.name])
      }else if (roomEvent.type === 'remove'){
        self.rooms = [].concat(self.rooms).filter(function(name){return name !== roomEvent.name})
      }
    }
  },
  // watch: {
  //   '$route': function(to, from){
  //     if (from.params.roomName){
  //       window.message = undefined
  //     }
  //     if (to.params.roomName){
  //       window.message = new WebSocket(wsPrefix()+ "/ws?room="+ $route.params.roomName)
  //     }
  //   }
  // }
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
