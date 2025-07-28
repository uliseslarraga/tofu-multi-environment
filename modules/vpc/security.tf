resource "aws_default_security_group" "default" {
    vpc_id = aws_vpc.this.id
  
    # Remove all default rules
    tags = merge(local.common_tags, {
        Name = "${var.project}-${local.environment}-default-sg-restricted"
    })
}

resource "aws_network_acl" "private" {
  count      = var.enable_network_acls ? 1 : 0
  vpc_id     = aws_vpc.this.id
  subnet_ids = aws_subnet.private[*].id
  
  # Allow inbound from VPC
  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = var.vpc_cidr
    from_port  = 0
    to_port    = 0
  }
  
  # Allow outbound to internet
  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  
  tags = merge(local.common_tags, {
    Name = "${var.project}-${local.environment}-private-nacl"
  })
}