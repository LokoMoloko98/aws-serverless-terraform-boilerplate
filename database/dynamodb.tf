resource "aws_dynamodb_table" "users-dynamodb-table" {
  name         = "${var.project_name}-users"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "user_name"
    type = "S"
  }

  hash_key  = "user_id"   # Partition Key
  range_key = "user_name" # Sort Key

  # Enable stream if needed for real-time updates
  stream_enabled   = true
  stream_view_type = "NEW_IMAGE"

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  point_in_time_recovery {
    enabled = true
  }

  lifecycle {
    ignore_changes = [
      write_capacity,
      read_capacity
    ]
  }

  tags = {
    Name        = "${var.project_name}-users-table"
    Environment = "production"
    Costs       = "${var.project_name}"
  }
}

# Example of a table for multiple user data storage
resource "aws_dynamodb_table" "music-catalogue-dynamodb-table" {
  name         = "${var.project_name}-music"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "song_id"
    type = "S"
  }

  # Table Keys
  hash_key  = "song_id" # Partition Key
  range_key = "user_id" # Sort Key

  # Enable stream if needed for real-time updates
  stream_enabled   = true
  stream_view_type = "NEW_IMAGE"

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  point_in_time_recovery {
    enabled = true
  }

  lifecycle {
    ignore_changes = [
      write_capacity,
      read_capacity
    ]
  }

  tags = {
    Name        = "${var.project_name}-music-table"
    Environment = "production"
    Costs       = "${var.project_name}"
  }
}