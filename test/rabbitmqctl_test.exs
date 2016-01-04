defmodule RabbitmqctlTest do
  use ExUnit.Case, async: true
  doctest Rabbitmqctl

  test "omitted command produces non-zero exit code, help and error" do
    assert Rabbitmqctl.process_args([]) ==
      [64, expected_usage, "Error: could not recognise command"]
  end

  test "an unknown command produces non-zero exit code, help and error" do
    assert Rabbitmqctl.process_args(["wewillneverhavethiscommand"]) ==
      [64, expected_usage, "Error: could not recognise command"]
  end

  test "help produces text with exit code 0" do
    assert Rabbitmqctl.process_args(["help"]) ==
      [0, expected_usage, nil]
  end

  defp expected_usage do
    ~s"""
Usage:
rabbitmqctl [-n <node>] [-t <timeout>] [-q] <command> [<command options>] 

Options:
    -n node
    -q
    -t timeout

Default node is "rabbit@server", where server is the local host. On a host 
named "server.example.com", the node name of the RabbitMQ Erlang node will 
usually be rabbit@server (unless RABBITMQ_NODENAME has been set to some 
non-default value at broker startup time). The output of hostname -s is usually 
the correct suffix to use after the "@" sign. See rabbitmq-server(1) for 
details of configuring the RabbitMQ broker.

Quiet output mode is selected with the "-q" flag. Informational messages are 
suppressed when quiet mode is in effect.

Operation timeout in seconds. Only applicable to "list" commands. Default is 
"infinity".

Commands:
    stop [<pid_file>]
    stop_app
    start_app
    wait <pid_file>
    reset
    force_reset
    rotate_logs <suffix>

    join_cluster <clusternode> [--ram]
    cluster_status
    change_cluster_node_type disc | ram
    forget_cluster_node [--offline]
    rename_cluster_node oldnode1 newnode1 [oldnode2] [newnode2 ...]
    update_cluster_nodes clusternode
    force_boot
    sync_queue queue
    cancel_sync_queue queue
    purge_queue queue
    set_cluster_name name

    add_user <username> <password>
    delete_user <username>
    change_password <username> <newpassword>
    clear_password <username>
    
            authenticate_user <username> <password>
          
    set_user_tags <username> <tag> ...
    list_users

    add_vhost <vhostpath>
    delete_vhost <vhostpath>
    list_vhosts [<vhostinfoitem> ...]
    set_permissions [-p <vhostpath>] <user> <conf> <write> <read>
    clear_permissions [-p <vhostpath>] <username>
    list_permissions [-p <vhostpath>]
    list_user_permissions <username>

    set_parameter [-p <vhostpath>] <component_name> <name> <value>
    clear_parameter [-p <vhostpath>] <component_name> <key>
    list_parameters [-p <vhostpath>]

    set_policy [-p <vhostpath>] [--priority <priority>] [--apply-to <apply-to>] 
<name> <pattern>  <definition>
    clear_policy [-p <vhostpath>] <name>
    list_policies [-p <vhostpath>]

    list_queues [-p <vhostpath>] [<queueinfoitem> ...]
    list_exchanges [-p <vhostpath>] [<exchangeinfoitem> ...]
    list_bindings [-p <vhostpath>] [<bindinginfoitem> ...]
    list_connections [<connectioninfoitem> ...]
    list_channels [<channelinfoitem> ...]
    list_consumers [-p <vhostpath>]
    status
    environment
    report
    eval <expr>

    close_connection <connectionpid> <explanation>
    trace_on [-p <vhost>]
    trace_off [-p <vhost>]
    set_vm_memory_high_watermark <fraction>
    set_vm_memory_high_watermark absolute <memory_limit>
    set_disk_free_limit <disk_limit>
    set_disk_free_limit mem_relative <fraction>

<vhostinfoitem> must be a member of the list [name, tracing].

The list_queues, list_exchanges and list_bindings commands accept an optional 
virtual host parameter for which to display results. The default value is "/".

<queueinfoitem> must be a member of the list [name, durable, auto_delete, 
arguments, policy, pid, owner_pid, exclusive, exclusive_consumer_pid, 
exclusive_consumer_tag, messages_ready, messages_unacknowledged, messages, 
messages_ready_ram, messages_unacknowledged_ram, messages_ram, 
messages_persistent, message_bytes, message_bytes_ready, 
message_bytes_unacknowledged, message_bytes_ram, message_bytes_persistent, 
head_message_timestamp, disk_reads, disk_writes, consumers, 
consumer_utilisation, memory, slave_pids, synchronised_slave_pids, state].

<exchangeinfoitem> must be a member of the list [name, type, durable, 
auto_delete, internal, arguments, policy].

<bindinginfoitem> must be a member of the list [source_name, source_kind, 
destination_name, destination_kind, routing_key, arguments].

<connectioninfoitem> must be a member of the list [pid, name, port, host, 
peer_port, peer_host, ssl, ssl_protocol, ssl_key_exchange, ssl_cipher, 
ssl_hash, peer_cert_subject, peer_cert_issuer, peer_cert_validity, state, 
channels, protocol, auth_mechanism, user, vhost, timeout, frame_max, 
channel_max, client_properties, recv_oct, recv_cnt, send_oct, send_cnt, 
send_pend, connected_at].

<channelinfoitem> must be a member of the list [pid, connection, name, number, 
user, vhost, transactional, confirm, consumer_count, messages_unacknowledged, 
messages_uncommitted, acks_uncommitted, messages_unconfirmed, prefetch_count, 
global_prefetch_count].

"""
  end
end
