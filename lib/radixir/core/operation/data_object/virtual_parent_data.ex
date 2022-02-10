defmodule Radixir.Core.Operation.DataObject.VirtualParentData do
  alias Radixir.RequestPiece

  def type(stitch_plans) do
    RequestPiece.type(stitch_plans, [type: "VirtualParentData"], [:data, :data_object])
  end

  def entity_set_identifier(stitch_plans, params) do
    schema = [
      address_regex: [
        type: :string,
        required: true
      ],
      virtual_data_object: [
        type: :string,
        required: true
      ]
    ]

    results = NimbleOptions.validate!(params, schema)

    address_regex = [
      keys: [:data, :data_object, :entity_state_identifier, :address_regex],
      value: Keyword.get(results, :address_regex)
    ]

    # TODO: figure out what goes here
    virtual_data_object = [
      keys: [:data, :data_object, :entity_state_identifier, :virtual_data_object],
      value: Keyword.get(results, :virtual_data_object)
    ]

    stitch_plan = [address_regex, virtual_data_object]

    stitch_plan ++ stitch_plans
  end
end
