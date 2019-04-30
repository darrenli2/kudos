var app = new Vue({
  el: '#app',
  data: {
    showTabGive: 'active',
    showTabReceived: '',
    showTabGiven: '',
    showTableGive: '',
    showTableReceived: 'd-none',
    showTableGiven: 'd-none',
    userName: '',
    userId: '',
    showSignOutError: 'd-none',
    showGiveKudosError: 'd-none',
    giveKudosError: '',
    message: '',
    receiverId: '',
    quantity: '1',
    leftQuantity: window.QUANTITY
  },
  methods: {
    signOut: function () {
      axios.delete(
        '/users/sign_out',
        this.headConfig()
      ).then(function (response) {
        window.location.href = '/';
      }).catch(function (error) {
        console.log(error);
        this.showSignOutError = '';
      })
    },
    giveKudos: function(receiverId){
      var _this = this;
      var data = { receiverId: this.receiverId, message: this.message, quantity: this.quantity }
      axios.post(
        '/kudos_transactions',
        data,
        this.headConfig()
      ).then(function (response) {
        _this.leftQuantity = response.data.quantity;
        $('#messageModal').modal('hide');
      }).catch(function (error) {
        _this.giveKudosError = error.response.data;
        _this.showGiveKudosError = '';
      })
    },
    tabGive: function(){
      debugger;
      this.showTabGive = 'active';
      this.showTabReceived = '';
      this.showTabGiven =  '';
      this.showTableGive = '';
      this.showTableReceived = 'd-none';
      this.showTableGiven =  'd-none';
    },

    tabReceived: function(){
      this.showTabGive = '';
      this.showTabReceived = 'active';
      this.showTabGiven =  '';
      this.showTableGive = 'd-none';
      this.showTableReceived = '';
      this.showTableGiven =  'd-none';
    },

    tabGiven: function(){
      this.showTabGive = '';
      this.showTabReceived = '';
      this.showTabGiven =  'active';
      this.showTableGive = 'd-none';
      this.showTableReceived = 'd-none';
      this.showTableGiven =  '';
    },
    setModalUser: function(userId, userName){
      this.userName = userName;
      this.receiverId = userId;
      this.message = '';
      this.quantity = '1';
      this.giveKudosError = ''
    },
    headConfig: function() {
      var config = { headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') , Accept: 'application/json' } };
      return config;
    }
  }
});