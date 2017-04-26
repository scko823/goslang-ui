<template>
  <div class="nav-menu">
    <h2>Add A New Room</h2>
    <form @submit.prevent="onSubmit">
      <input type="text" placeholder="room name" v-model="roomName">
      </input>
    </form>
  </div>
</template>

<script>
export default {
  name: 'AddRoom',
  data () {
    return {
      roomName: ''
    }
  },
  methods: {
    onSubmit(){
      alert(this.roomName)
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
