Hanami::Model.migration do
  change do
    create_table :campaigns do
      primary_key :id
      column :job_id, String, null: false
      column :status, String, null: false
      column :external_reference, String, null: false
      column :ad_description, String, null: false
    end
  end
end
