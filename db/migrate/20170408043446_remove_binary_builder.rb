# frozen_string_literal: true
class RemoveBinaryBuilder < ActiveRecord::Migration[5.0]
  class Stage < ActiveRecord::Base
  end

  def up
    if Stage.columns.detect { |c| c.name == "docker_binary_plugin_enabled" }
      Stage.where(docker_binary_plugin_enabled: true).each do |stage|
        puts "Removing binary builder from #{stage.name} -- #{stage.id}"
      end
      remove_column :stages, :docker_binary_plugin_enabled
    end
  end

  def down
    add_column :stages, :docker_binary_plugin_enabled, :boolean, default: false, null: false
  end
end
