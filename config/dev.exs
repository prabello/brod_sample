import Config

config :brod,
  clients: [
    # You can choose the name of the client
    kafka_client: [
      endpoints: [localhost: 9092]
      # auto_start_producers: true  # This will auto-start the producers with default configs
    ]
  ]
