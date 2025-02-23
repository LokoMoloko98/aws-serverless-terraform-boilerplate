# Outputs
output "amplify_app_url" {
  value = "https://${aws_amplify_domain_association.music-catalogue-dns.domain_name}"
}

output "amplify_app_id" {
  value = aws_amplify_app.boilerplate-app.id
}