variable "pubsub_prefix" {
    type = string
    default = "Operational_Security_"
}

variable "loggingsink_folder_id" {
    type = string
    default = "954902212336"
}

variable "topic_names" {
    type    = list
    default = ["Admin_Activity_Topic", 
        "Access_Transparency_Topic", 
        "System_Events_Topic", 
        "FW_Log_Topic", 
        "Compute_Logs_Topic", 
        "HTTP_LB_Topic", 
        "VPC_Flowlogs_Topic",
        "Data_Access_Topic"]
}

variable "subscription_names" {
    type    = list
    default = ["_Admin_Activity_Sub", 
        "_Access_Transparency_Sub", 
        "_System_Events_Sub", 
        "_FW_Log_Sub", 
        "_Compute_Logs_Sub", 
        "_HTTP_LB_Sub", 
        "_VPC_Flowlogs_Sub",
        "_Data_Access_Sub"]
}

variable "filters" {
    type = map
    default = {
        Admin_Activity = "logName:activity"
        Access_Transparency = "logName:access_transparency"
        System_Events = "logName:system_event"
        FW_Log = "logName:firewall"
        Compute_Logs = "logName:syslog"
        HTTP_LB = "resource.type=http_load_balancer"
        VPC_Flowlogs = "logName:vpc_flows"
        Data_Access = "logName:data_access"
    }
}