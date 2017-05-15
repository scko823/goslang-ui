<template>
  <div class="room">
    <h2>{{$route.params.roomName}}</h2>
    <ul>
      <li v-for="m in messages">
        {{m}}
      </li>
    </ul>
    <form @submit.prevent="onSendMsg">
      <input
        v-bind:disabled="disabled"
        type="text"
        placeholder="type message here"
        v-model="newMsgText"
      />
    </form>
  </div>
</template>

<script>
import {wsPrefix} from '../utils/config.js'

export default {
  name: 'Room',
  data () {
    return {
      messages : [],
      newMsgText: '',
      disabled: true
    }
  },
  methods: {
    onSendMsg: function(){
      let self = this
      window.messages.send(JSON.stringify({
        time: Math.trunc(new Date().getTime()/1000),
        room:self.$route.params.roomName,
        message: self.newMsgText
      }))
      this.newMsgText = ''
    },
    _connectWS: function(){
      let self = this
      let myRoute = Object.assign({}, this.$route)
      let roomName = myRoute.params.roomName
      console.log("Attempting to get new ws to room "+ roomName)
      window.messages = new WebSocket(wsPrefix()+"/ws?room="+roomName)
      window.messages.onopen = function(){
        self.disabled = false
        console.log("message websocket open")
      }
      window.messages.onmessage = function(event){
        let data = JSON.parse(event.data)
        self.messages = self.messages.concat([data])
      }
    }
  },
  mounted: function(){
    this._connectWS();
    console.log('mounted')
  },
  watch: {
    '$route.params.roomName':function(e){
      this.disabled=true
      this.messages=[]
      this.newMsgText=''
      if (window.messages){
        window.messages.close()
      }
      this._connectWS()
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
