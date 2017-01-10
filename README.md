# Hyperfocal

## Installation

Visit [hyperfocal.io](http://hyperfocal.io) to set up an account, and find installation instructions

## Usage

After making sure you have an account on Hyperfocal, you can use the following
 in your application.

### Event Tracking

To track an event, simply use this line in your application
 `Hyperfocal.event('event_name', other_attributes_as_hash)`

Optional (but helpful) attributes to include

```
user_id: Used to filter events by user/unique user
```

This will send an event to Hyperfocal


### Metric Tracking

Hyperfocal allows you to report metrics to the system. You can view them,
 as averages, mins, or maxs.

To track a metric, use the following code in your application
 `Hyperfocal.metric('metric_name', 'metric_value',  other_attributes_as_hash)`

The supported metric values are strings, and integers. If you report the metrics
 as integers, you can use the average, min, and max reporting type in Hyperfocal


### User Tracking

If you'd like to see more detailed information about your users in Hyperfocal,
 you can report the User information to Hyperfocal.

To report a user to Hyperfocal, simply use the following
 `Hyperfocal.user(attributes_as_hash)`.

The only required field for a user, is whatever unique identifier is used by
 your application. This is required to be unique for all your users,
 as if you report two differnet users with the same ID. We will overwrite the
 previous information, as the reported information is taken as gospel.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

