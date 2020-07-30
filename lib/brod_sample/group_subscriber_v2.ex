defmodule BrodSample.GroupSubscriberV2 do
  # @behaviour :brod_group_member
  require Logger

  def start() do
    group_config = [
      offset_commit_policy: :commit_to_kafka_v2,
      offset_commit_interval_seconds: 5,
      rejoin_delay_seconds: 2,
      reconnect_cool_down_seconds: 10
    ]

    config = [
      client: :kafka_client,
      group_id: "consumer_group",
      topics: ["reviews.reviews"],
      cb_module: __MODULE__,
      group_config: group_config,
      consumer_config: [begin_offset: :earliest]
    ]

    :brod.start_link_group_subscriber_v2(config)
  end

  def init(_arg, _arg2) do
    {:ok, []}
  end

  def handle_message(message, state) do
    IO.inspect(message, label: "message")
    IO.inspect(state, label: "state")

    {:ok, :ack, state}
  end

  # assign_partitions/3, get_committed_offset/3.
end
