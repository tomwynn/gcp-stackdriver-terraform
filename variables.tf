variable "pubsub_prefix" {
    type = string
    default = "Operational_Security_"
}

variable "loggingsink_folder_id" {
    type = string
    default = "[folder_id]"
}

variable "topic_names" {
    type    = list
    default = ["Admin_Activity_Topic", 
        "System_Events_Topic", 
        "VPC_Flowlogs_Topic",
        "Data_Access_Topic"]
}

variable "subscription_names" {
    type    = list
    default = ["_Admin_Activity_Sub", 
        "_System_Events_Sub", 
        "_VPC_Flowlogs_Sub",
        "_Data_Access_Sub"]
}

variable "filters" {
    type = map
    default = {
        Admin_Activity = "logName:activity"
        System_Events = "logName:system_event"
        VPC_Flowlogs = "logName:vpc_flows"
        Data_Access = "logName:data_access"
    }
}
