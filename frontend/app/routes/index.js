import Ember from 'ember';

export default Ember.Route.extend({
  cable: Ember.inject.service(),

  reconnecting: false,

  model() {
    // fetch all data for user
    return Ember.RSVP.hash({
      items: this.get('store').findAll('item'),
      subscriptions: this.get('store').findAll('subscription')
    });
  },

  activate() {
    this._super(...arguments);

    let cable = this.get('cable').createConsumer(`${location.protocol === 'https:' ? 'wss:' : 'ws:'}//${location.host}/cable`);

    let feed = cable.subscriptions.create('FeedChannel');
    feed.connected = () => {
      Ember.Logger.debug('[feed] connected');
      if (this.get('reconnecting')) {
        // fetch anything we missed
        this.get('store').unloadAll();
        this.refresh();
      }
      this.set('reconnecting', false);
    };
    feed.disconnected = () => {
      Ember.Logger.debug('[feed] disconnected');
      this.set('reconnecting', true);
    };
    feed.received = (data) => {
      Ember.Logger.debug('[feed] message', data);
      switch (data.action) {
        case 'create':
        case 'update':
          this.get('store').pushPayload(data.payload);
          break;
        case 'destroy': {
          let record = this.get('store').peekRecord(data.type, data.id);
          if (record && !record.get('isDeleted')) {
            record.deleteRecord();
          }
          break;
        }
      }
    };
  }
});
