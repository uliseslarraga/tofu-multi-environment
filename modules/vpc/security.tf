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
  

  # === INGRESS RULES (Inbound to private subnets) ===
  
  # Health check traffic from ALB
  ingress {
    rule_no    = 100
    protocol   = "tcp"
    action     = "allow"
    cidr_block = var.vpc_cidr  # ALB in public subnets
    from_port  = 80
    to_port    = 80
  }
  
  ingress {
    rule_no    = 110
    protocol   = "tcp"
    action     = "allow"
    cidr_block = var.vpc_cidr
    from_port  = 443
    to_port    = 443
  }
  
  # Custom application ports
  ingress {
    rule_no    = 120
    protocol   = "tcp"
    action     = "allow"
    cidr_block = var.vpc_cidr
    from_port  = 8000
    to_port    = 8999
  }
  
  # Ephemeral ports for return traffic (CRITICAL for both health checks and SSM)
  ingress {
    rule_no    = 130
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
  
  # SSH access (optional)
  ingress {
    rule_no    = 140
    protocol   = "tcp"
    action     = "allow"
    cidr_block = var.vpc_cidr
    from_port  = 22
    to_port    = 22
  }

  # === EGRESS RULES (Outbound from private subnets) ===
  
  # HTTPS for SSM and other AWS services
  egress {
    rule_no    = 100
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }
  
  # HTTP for package updates
  egress {
    rule_no    = 110
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  
  # DNS queries
  egress {
    rule_no    = 120
    protocol   = "udp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 53
    to_port    = 53
  }
  
  # NTP for time sync
  egress {
    rule_no    = 130
    protocol   = "udp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 123
    to_port    = 123
  }
  
  # Ephemeral ports for responses back to ALB
  egress {
    rule_no    = 140
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
  
  tags = merge(local.common_tags, {
    Name = "${var.project}-${local.environment}-private-nacl"
  })
}
