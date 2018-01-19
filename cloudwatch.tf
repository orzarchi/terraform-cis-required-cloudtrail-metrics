resource "aws_cloudwatch_log_group" "cloudtrail-events" {
  name = "cloudtrail-events"
}

resource "aws_sns_topic" "cloudtrail-sns-topic" {
  name = "cloudtrail-alarms"
}

resource "aws_cloudwatch_log_metric_filter" "cis-cloudtrail-filters" {

  log_group_name = "${var.log_group}"
  "metric_transformation" {
    name = "${lookup(var.metric_filters[count.index], "name")}"
    namespace = "CisBenchmarks"
    value = "1"
  }
  name = "${lookup(var.metric_filters[count.index], "name")}Filter"
  pattern = "${lookup(var.metric_filters[count.index], "pattern")}"
  count = "${var.enabled == "true" ? length(var.metric_filters) : 0}"
}

resource "aws_cloudwatch_metric_alarm" "cis-cloudtrail-alarms" {
  count = "${var.enabled == "true" ? length(var.metric_filters) : 0}"
  alarm_name = "${lookup(var.metric_filters[count.index], "name")}Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "${lookup(var.metric_filters[count.index], "name")}"
  namespace = "CisBenchmarks"
  statistic = "Sum"
  period = 300
  threshold = 1.0
  alarm_actions = ["${aws_sns_topic.cloudtrail-sns-topic.arn}"]
}

