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
      console.log("Attempting to get new ws to room "+ $route.params.roomName)
      window.messages = new WebSocket("ws://" + document.location.host + "/ws?room="+self.$route.params.roomName)
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
    console.log('beforeMount')
  },
  watch: {
    '$route.params.roomName':function(e){
      this.disabled=true
      this.messages=[]
      this.newMsgText=''
      window.messages.close()
      this._connectWS()
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
