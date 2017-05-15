module.exports = {
  wsPrefix: (roomName) => {
    if (process.env.NODE_ENV === 'production') {
      return `ws://${document.location.host}`
    } else {
      return `ws://localhost:8080`
    }
  }
}
