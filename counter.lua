obs = obslua

source_name = "counter"
interval = 1000

function get_text()
    local source = obs.obs_get_source_by_name(source_name)
    if source then
        local settings = obs.obs_source_get_settings(source)
        local text = obs.obs_data_get_string(settings, "text")
        
        obs.obs_data_release(settings)
        obs.obs_source_release(source)
        
        return tonumber(text) or 0
    end

    return 0
end

function update_counter()
    local new_value = get_text() + 1
    local source = obs.obs_get_source_by_name(source_name)
    
    if source then
        local settings = obs.obs_data_create()
        obs.obs_data_set_string(settings, "text", tostring(new_value))
        obs.obs_source_update(source, settings)
        
        obs.obs_data_release(settings)
        obs.obs_source_release(source)
    end
end

function script_load()
    obs.timer_add(update_counter, interval)
end