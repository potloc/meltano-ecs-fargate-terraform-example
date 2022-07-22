# # https://laysontheclouds.wordpress.com/2020/06/16/mount-efs-on-ecs-fargate-with-terraform-aws/
# # https://medium.com/@ilia.lazebnik/attaching-an-efs-file-system-to-an-ecs-task-7bd15b76a6ef
# # https://gitlab.com/meltano/infra/terraform/-/tree/main/aws/modules/infrastructure
# resource "aws_efs_file_system" "efs" {
#   tags = {
#     Name = "meltano-efs-file-system"
#   }
# }

# resource "aws_efs_mount_target" "mount" {
#   count           = length(data.aws_subnet_ids.private.ids)
#   file_system_id  = aws_efs_file_system.efs.id
#   subnet_id       = tolist(data.aws_subnet_ids.private.ids)[count.index]
#   security_groups = [data.aws_security_group.default.id]
# }
