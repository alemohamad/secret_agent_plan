require 'test_helper'

class MissionTest < ActiveSupport::TestCase
  test 'has valid test data' do
    Mission.find_each do |mission|
      assert_valid mission
    end
  end

  test 'status defaults to pending' do
    mission = Mission.new
    assert_equal 'pending', mission.status
  end

  test 'should require a description' do
    invalid_mission = Mission.new
    assert_invalid invalid_mission
    assert_includes invalid_mission.errors[:description], "can't be blank"
  end

  test 'should require a code_name' do
    invalid_mission = Mission.new
    assert_invalid invalid_mission
    assert_includes invalid_mission.errors[:code_name], "can't be blank"
  end

  test 'should require a unique code_name' do
    copy = Mission.new(code_name: missions(:alpha).code_name)
    assert_invalid copy
    assert_includes copy.errors[:code_name], 'has already been taken'
  end

  test 'status must be pending, active, completed, or failed' do
    mission = Mission.new(code_name: 'test', description: 'test description', status: 'pending')
    assert_valid mission
    mission.status = 'active'
    assert_valid mission
    mission.status = 'completed'
    assert_valid mission
    mission.status = 'failed'
    assert_valid mission
    mission.status = 'travelling'
    assert_invalid mission
  end

  test 'Mission.active should collect active missions' do
    active_missions = Mission.active
    active_missions.each do |mission|
      assert_equal 'active', mission.status
    end
  end

  test 'active? returns whether a mission status is active' do
    active_mission = missions(:beta)
    assert active_mission.active?
  end
end
