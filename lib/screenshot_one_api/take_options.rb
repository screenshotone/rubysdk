module ScreenshotOneApi
  class TakeOptions

    OPTIONS = [
      :url,
      :html,:markdown, :selector, :format, :response_type,
      :full_page, :full_page_scroll, :full_page_scroll_delay, :full_page_scroll_by,
      :viewport_device, :viewport_width, :viewport_height,
      :device_scale_factor, :viewport_mobile, :viewport_has_touch, :viewport_landscape,
      :image_quality, :image_width, :image_height,
      :omit_background, :dark_mode, :reduced_motion, :media_type, :hide_selectors,
      :scripts, :scripts_wait_until, :styles, :click,
      :block_cookie_banners, :block_chats, :block_ads, :block_trackers, :block_requests, :block_resources,
      :geolocation_latitude, :geolocation_longitude, :geolocation_accuracy,
      :proxy, :user_agent, :authorization, :cookies, :headers, :time_zone,
      :wait_until, :delay, :timeout, :wait_for_selector,
      :cache, :cache_ttl, :cache_key,
      :store, :storage_path, :storage_bucket, :storage_class,
      :error_on_selector_not_found
    ]
    BOOLEAN_OPTIONS = [
      :full_page, :full_page_scroll, :viewport_mobile, :viewport_has_touch, :viewport_landscape, :omit_background,
      :dark_mode, :reduced_motion, :block_cookie_banners, :block_chats, :block_ads, :block_trackers,
      :cache, :store, :error_on_selector_not_found
    ]
    NUMERIC_OPTIONS = [
      :full_page_scroll_delay, :full_page_scroll_by, :viewport_width, :viewport_height,
      :device_scale_factor, :image_width, :image_height,
      :geolocation_latitude, :geolocation_longitude, :geolocation_accuracy,
      :delay, :timeout, :cache_ttl
    ]
    ENUM_OPTIONS = {
      format: %w(png jpeg jpg webp gif jp2 tiff avif heif html),
      response_type: %w(by_format empty),
      scripts_wait_until: %w(load domcontentloaded networkidle0 networkidle2),
      block_resources: %w(document stylesheet image media font script texttrack xhr fetch eventsource websocket manifest other),
      time_zone: %w(America/Santiago Asia/Shanghai Europe/Berlin America/Guayaquil Europe/Madrid Pacific/Majuro Asia/Kuala_Lumpur Pacific/Auckland Europe/Lisbon Europe/Kiev Asia/Tashkent Europe/London),
      wait_until: %w(load domcontentloaded networkidle0 networkidle2),
      storage_class: %w(standard reduced_redundancy standard_ia onezone_ia intelligent_tiering glacier deep_archive outposts glacier_ir)
    }

    def initialize(url: nil)
      @url = url
    end

    OPTIONS.each do |option|

      define_method(option) do |*value|
        return instance_variable_get("@#{option}") if value.empty?

        instance_variable_set("@#{option}", value[0])
        self
      end

      define_method("#{option}?") do
        !!instance_variable_get("@#{option}")
      end
    end

    def to_hash
      instance_variables.each_with_object({}) do |var, hash|
        hash[var.to_s.delete('@')] = instance_variable_get(var)
      end
    end

    def valid?
      ENUM_OPTIONS.each do |option, values|
        if send("#{option}?")
          return false unless values.include?(send(option).to_s)
        end
      end

      BOOLEAN_OPTIONS.each do |option|
        if send("#{option}?")
          return false unless [true, false].include?(send(option))
        end
      end

      NUMERIC_OPTIONS.each do |option|
        if send("#{option}?")
          return false unless send(option).to_f.to_s == send(option).to_s || send(option).to_i.to_s == send(option).to_s
        end
      end

      true
    end

  end
end