defmodule BrodSample.Consumer do
  @behaviour :brod_group_subscriber
  require Logger

  def start() do
    group_config = [
      offset_commit_policy: :commit_to_kafka_v2,
      offset_commit_interval_seconds: 5,
      rejoin_delay_seconds: 2
    ]

    {:ok, _subscriber} =
      :brod.start_link_group_subscriber(
        :kafka_client,
        "consumer_group_name",
        ["streaming.events"],
        group_config,
        _consumer_config = [begin_offset: :earliest],
        _callback_module = __MODULE__,
        _callback_init_args = {:kafka_client, ["streaming.events"]}
      )
  end

  def handle_message(topic, partition, message, state) do
    Logger.info("Received #{inspect(message)} from
      #{inspect(topic)} on #{inspect(partition)} with the current #{inspect(state)}")

    # {:ok, state} # dont ack the message
    # ack the message
    {:ok, :ack, state}
  end

  def init(group_id, _callback_init_args = {client_id, topics}) do
    IO.inspect(client_id, label: "Client")
    IO.inspect(topics, label: "topics")
    IO.inspect(group_id, label: "GroupId")
    {:ok, []}
  end
end
