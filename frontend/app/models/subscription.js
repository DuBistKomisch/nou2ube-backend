import { get } from '@ember/object';
import { computed } from '@ember/object';
import { alias, filterBy } from '@ember/object/computed';

import DS from 'ember-data';
const { Model, belongsTo, hasMany } = DS;

export default class SubscriptionModel extends Model {
  @belongsTo('channel') channel;
  @hasMany('items') items;

  @filterBy('items', 'new') newItems;
  @computed('newItems')
  get hasNew() {
    return this.newItems.length > 0;
  }

  @filterBy('items', 'later') laterItems;
  @computed('laterItems')
  get hasLater() {
    return this.laterItems.length > 0;
  }

  @computed('channel.title')
  get sortableTitle() {
    return get(this.channel, 'title').toLowerCase();
  }

  @computed('items')
  get totalDuration() {
    return this.items.map((item) => get(item.video, 'duration')).reduce((acc, n) => acc + n, 0);
  }

  @alias('items.length') itemCount;
}
