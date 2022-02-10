defmodule Radixir.Core.Operation do
  alias Radixir.RequestPiece

  def type(stitch_plans, params) do
    type_options = ["Resource", "Data", "ResourceAndData"]

    schema = [
      type: [
        type: :string,
        required: true
      ]
    ]

    type =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:type)

    if type not in type_options,
      do: raise(ArgumentError, message: "type can only be Resource, Data, or ResourceAndData")

    stitch_plan = [[keys: [:type], value: type]]

    stitch_plan ++ stitch_plans
  end

  defdelegate entity_identifier(stitch_plans, params), to: RequestPiece

  def sub_entity(stitch_plans, params) do
    RequestPiece.sub_entity(stitch_plans, params, [:entity_identifer])
  end

  def substate(stitch_plans, params) do
    substate_operation_options = ["BOOTUP", "SHUTDOWN"]

    schema = [
      substate_operation: [
        type: :string,
        required: true
      ],
      identifier: [
        type: :string,
        required: true
      ]
    ]

    results = NimbleOptions.validate!(params, schema)
    substate_operation_value = Keyword.get(results, :substate_operation)

    if substate_operation_value not in substate_operation_options,
      do:
        raise(ArgumentError,
          message: "operation data substate_operation can only be CREATE or DELETE"
        )

    substate_operation = [
      keys: [:substate, :substate_operation],
      value: substate_operation_value
    ]

    identifier = [
      keys: [:substate, :substate_identifier, :identifier],
      value: Keyword.get(results, :identifier)
    ]

    stitch_plan = [substate_operation, identifier]

    stitch_plan ++ stitch_plans
  end

  defdelegate amount(stitch_plans, params), to: RequestPiece

  def data(stitch_plans, params) do
    action_options = ["CREATE", "DELETE"]

    schema = [
      action: [
        type: :string,
        required: true
      ]
    ]

    action =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:action)

    if action not in action_options,
      do: raise(ArgumentError, message: "operation data action can only be CREATE or DELETE")

    stitch_plan = [[keys: [:data, :action], value: action]]

    stitch_plan ++ stitch_plans
  end

  def metadata(stitch_plans, params) do
    schema = [
      type: [
        substate_data_hex: :string,
        required: true
      ]
    ]

    substate_data_hex =
      NimbleOptions.validate!(params, schema)
      |> Keyword.get(:substate_data_hex)

    stitch_plan = [[keys: [:metadata, :substate_data_hex], value: substate_data_hex]]

    stitch_plan ++ stitch_plans
  end
end
