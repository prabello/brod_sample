defmodule BrodSample.CreateTopic do
  def create() do
    topic_config = [
      %{
        config_entries: [],
        num_partitions: 6,
        replica_assignment: [],
        replication_factor: 1,
        topic: "reviews.snapshots"
      }
    ]

    :brod.create_topics(
      ["kafka-default.dev.podium-dev.com": 19092],
      topic_config,
      %{timeout: 1_000}
    )

    # :brod.create_topics(
    #   ["kafka-default.dev.podium-dev.com": 19092],
    #   ["test_create_topic"],
    #   %{timeout: 1_000}
    # )
  end
end
