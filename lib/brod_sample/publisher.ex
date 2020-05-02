defmodule BrodSample.Publisher do
  def publish(topic, partition_key, message) do
    {:ok, count} = :brod.get_partitions_count(:kafka_client, topic)

    :brod.produce_sync(
      :kafka_client,
      topic,
      :erlang.phash2(partition_key, count),
      partition_key,
      message
    )
  end
end
