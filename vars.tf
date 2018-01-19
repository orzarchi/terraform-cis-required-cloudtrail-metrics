variable "enabled"{
  default = "false"
}

variable "metric_filters" {
  type = "list"
  default = [
    {
      benchmark = "3.1",
      description = "Ensure a log metric filter and alarm exist for unauthorized API calls",
      level = 1,
      name = "UnauthorizedApiCalls",
      pattern = "{ ($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\") }"
    },
    {
      benchmark = "3.2",
      description = "Ensure a log metric filter and alarm exist for Management Console sign-in without MFA",
      level = 1,
      name = "NoMfaConsoleLogins",
      pattern = "{ $.userIdentity.sessionContext.attributes.mfaAuthenticated != \"true\" && $.userIdentity.invokedBy = \"signin.amazonaws.com\" }"
    },
    {
      benchmark = "3.3",
      description = "Ensure a log metric filter and alarm exist for usage of \"root\" account",
      level = 1,
      name = "RootAccountLogins",
      pattern = "{ $.userIdentity.type = \"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType != \"AwsServiceEvent\" }"
    },
    {
      benchmark = "3.4",
      description = "Ensure a log metric filter and alarm exist for IAM policy changes",
      level = 1,
      name = "IamPolicyChanges",
      pattern = "{($.eventName=DeleteGroupPolicy)||($.eventName=DeleteRolePolicy)||($.eventName=DeleteUserPolicy)||($.eventName=PutGroupPolicy)||($.eventName=PutRolePolicy)||($.eventName=PutUserPolicy)||($.eventName=CreatePolicy)||($.eventName=DeletePolicy)||($.eventName=CreatePolicyVersion)||($.eventName=DeletePolicyVersion)||($.eventName=AttachRolePolicy)||($.eventName=DetachRolePolicy)||($.eventName=AttachUserPolicy)||($.eventName=DetachUserPolicy)||($.eventName=AttachGroupPolicy)||($.eventName=DetachGroupPolicy)}"
    },
    {
      benchmark = "3.5",
      description = "Ensure a log metric filter and alarm exist for CloudTrail configuration changes",
      level = 1,
      name = "CloudTrailConfigurationChanges",
      pattern = "{ ($.eventName = CreateTrail) ||($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging) }"
    },
    {
      benchmark = "3.6",
      description = "Ensure a log metric filter and alarm exist for AWS Management Console authentication failures",
      level = 2,
      name = "FailedConsoleLogins",
      pattern = "{ ($.eventName = ConsoleLogin) && ($.errorMessage = \"Failed authentication\") }"
    },
    {
      benchmark = "3.7",
      description = "Ensure a log metric filter and alarm exist for disabling or scheduled deletion of customer created CMKs",
      level = 2,
      name = "DisabledOrDeletedCmks",
      pattern = "{($.eventSource = kms.amazonaws.com) && (($.eventName=DisableKey)||($.eventName=ScheduleKeyDeletion))}"
    },
    {
      benchmark = "3.8",
      description = "Ensure a log metric filter and alarm exist for S3 bucket policy changes",
      level = 1,
      name = "S3BucketPolicyChanges",
      pattern = "{ ($.eventSource = s3.amazonaws.com) && (($.eventName = PutBucketAcl) || ($.eventName = PutBucketPolicy) || ($.eventName = PutBucketCors) || ($.eventName = PutBucketLifecycle) || ($.eventName = PutBucketReplication) || ($.eventName = DeleteBucketPolicy) || ($.eventName = DeleteBucketCors) || ($.eventName = DeleteBucketLifecycle) || ($.eventName = DeleteBucketReplication)) }"
    },
    {
      benchmark = "3.9",
      description = "Ensure a log metric filter and alarm exist for AWS Config configuration changes",
      level = 2,
      name = "AwsConfigChanges",
      pattern = "{($.eventSource = config.amazonaws.com) && (($.eventName=StopConfigurationRecorder)||($.eventName=DeleteDeliveryChannel)||($.eventName=PutDeliveryChannel)||($.eventName=PutConfigurationRecorder))}"
    },
    {
      benchmark = "3.10",
      description = "Ensure a log metric filter and alarm exist for security group changes",
      level = 2,
      name = "SecurityGroupChanges",
      pattern = "{ ($.eventName = AuthorizeSecurityGroupIngress) || ($.eventName = AuthorizeSecurityGroupEgress) || ($.eventName = RevokeSecurityGroupIngress) || ($.eventName = RevokeSecurityGroupEgress) || ($.eventName = CreateSecurityGroup) || ($.eventName = DeleteSecurityGroup)}"
    },
    {
      benchmark = "3.11",
      description = "Ensure a log metric filter and alarm exist for changes to Network Access Control Lists",
      level = 2,
      name = "NetworkAccessControlListChanges",
      pattern = "{ ($.eventName = CreateNetworkAcl) || ($.eventName = CreateNetworkAclEntry) || ($.eventName = DeleteNetworkAcl) || ($.eventName = DeleteNetworkAclEntry) || ($.eventName = ReplaceNetworkAclEntry) || ($.eventName = ReplaceNetworkAclAssociation) }"
    },
    {
      benchmark = "3.12",
      description = "Ensure a log metric filter and alarm exist for changes to network gateways",
      level = 1,
      name = "NetworkGatewayChanges",
      pattern = "{ ($.eventName = CreateCustomerGateway) || ($.eventName = DeleteCustomerGateway) || ($.eventName = AttachInternetGateway) || ($.eventName = CreateInternetGateway) || ($.eventName = DeleteInternetGateway) || ($.eventName = DetachInternetGateway) }"
    },
    {
      benchmark = "3.13",
      description = "Ensure a log metric filter and alarm exist for route table changes",
      level = 1,
      name = "RouteTableChanges",
      pattern = "{ ($.eventName = CreateRoute) || ($.eventName = CreateRouteTable) || ($.eventName = ReplaceRoute) || ($.eventName = ReplaceRouteTableAssociation) || ($.eventName = DeleteRouteTable) || ($.eventName = DeleteRoute) || ($.eventName= DisassociateRouteTable) }"
    },
    {
      benchmark = "3.14",
      description = "Ensure a log metric filter and alarm exist for VPC changes",
      level = 1,
      name = "VPCChanges",
      pattern = "{ ($.eventName = CreateVpc) || ($.eventName = DeleteVpc) || ($.eventName = ModifyVpcAttribute) || ($.eventName = AcceptVpcPeeringConnection) || ($.eventName = CreateVpcPeeringConnection) || ($.eventName = DeleteVpcPeeringConnection) || ($.eventName = RejectVpcPeeringConnection) || ($.eventName = AttachClassicLinkVpc) || ($.eventName = DetachClassicLinkVpc) || ($.eventName = DisableVpcClassicLink) || ($.eventName = EnableVpcClassicLink) }"
    }
  ]
}

variable "log_group" {
  default = "CloudTrail/DefaultLogGroup"
}
