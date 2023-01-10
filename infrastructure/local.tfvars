location                    = "francecentral"
prefix                      = "mlops"
environment                 = "dev"
postfix                     = "001"
enable_aml_computecluster   = false
enable_aml_secure_workspace = false
enable_monitoring           = false
client_secret               = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
enable_feature_store        = true
sql_admin_user              = "sqladmin"
sql_admin_password          = "ThisIsNotVerySecure!"
fs_onlinestore_conn_name    = "FEATHR-ONLINE-STORE-CONN"
feathr_app_image            = "feathrfeaturestore/feathr-registry"
feathr_app_image_tag        = "releases-v0.9.0"
react_enable_rbac           = true
aad_client_id               = "350c2ffa-b4cf-49e4-8c59-feb23dd83e9f" # AAD Client ID

