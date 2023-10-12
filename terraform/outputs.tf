output "fe-subnets" {
  value = [for subnet in module.rsi-vnet-fe.vnet_subnets : subnet]
}