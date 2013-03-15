Capabilities
------------

The Dasein Cloud AWS implementation supports a large number of Amazon
Web Services and their equivalents on other platforms. However, there's
also a large number of services not supported. The following describes
how AWS is mapped to Dasein Cloud:

-  Instances -> VirtualMachine
-  Machine images -> MachineImage
-  Elastic Block Storage -> Volume
-  EBS Snapshots -> Snapshot
-  Keypairs -> SSHKeypair
-  VPCs/Subnets -> VLAN/Subnet
-  VPCGateway -> VPN/VPNGateway
-  Security Groups -> Firewall
-  Elastic IP -> IpAddress
-  Elastic Load Balancer -> LoadBalancer
-  Auto Scaling -> AutoScaling
-  IAM -> IdentityAndAccess
-  Route53 -> DNS
-  CloudFront -> CDN
-  RDS -> RelationalDatabase
-  SimpleDB -> KeyValueDatabase
-  SNS -> NotificationTopic
-  SQS -> Queue
-  S3 -> BlobStore

We're working to add services into Dasein Cloud to achieve full
coverage. AWS moves fast enough, however, that full coverage may never
actually happen.
