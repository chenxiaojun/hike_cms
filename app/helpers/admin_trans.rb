module AdminTrans
  BANNER_TARGET_TYPE = %w[Activity Topic].collect { |i| [I18n.t("banner.#{i}"), i] }
end