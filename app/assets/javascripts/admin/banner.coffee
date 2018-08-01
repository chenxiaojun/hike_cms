$ ->
  if ($('#index_table_banners').length > 0)
    $('#index_table_banners tbody').sortable(
      update: (e, ui) ->
        itemId = ui.item.attr('id')
        prevId = ui.item.prev().attr('id')
        nextId = ui.item.next().attr('id')

        $.ajax
          url: "/admin/banners/#{itemId.split('_').pop()}/reposition"
          type: "POST"
          data:
            id: itemId
            prev_id: prevId
            next_id: nextId
    );

  window.BannerEvent =
    bindFormEvents: ->
      @bindSuccessCallback();
      @TargetTypeSelect();

    TargetTypeSelect: ->
      $("select.banner_search_form").on 'change', (e) ->
        switch this.value
          when 'Activity'
            $('div.activities').show();
            $('div.topics').hide();
            $('#btn_search_activities').click();
            $('#input_search_activities').focus();
          when 'Topic'
            $('div.topics').show();
            $('div.activities').hide();
            $('#btn_search_topics').click();
            $('#input_search_topics').focus();
          else
            $('div.topics').hide();
            $('div.activities').hide();

    bindSuccessCallback: ->
      that = @
      $('.search_activities_form').on 'ajax:success', (e, data) ->
        $('.activities tbody tr').remove();
        $(that.createActivities(data)).appendTo('.activities tbody')
        that.targetClick();

      $('.search_topics_form').on 'ajax:success', (e, data) ->
        $('.topics tbody tr').remove();
        $(that.createTopics(data)).appendTo('.topics tbody')
        that.targetClick();

    targetClick: ->
      $('.targets tbody tr').on 'click', (e) ->
        id = $(this).data('id')
        title = $(this).data('title')
        $('input.target_id').val(id)
        $('input.target_name').val(title)

    createActivities: (activities) ->
      if activities.length == 0
        trs = '<tr><td>没有相关数据</td></tr>'
      else
        trs = ''
      for activity in activities
        trs += "<tr data-id=#{activity.id} data-title=#{activity.name} data-type='activity'>"
        trs += "<td>#{activity.id}</td>"
        trs += "<td>#{activity.name}</td>"
        trs += '/<tr>'
      trs

    createTopics: (topics) ->
      if topics.length == 0
        trs = '<tr><td>没有相关数据</td></tr>'
      else
        trs = ''
      for topic in topics
        trs += "<tr data-id=#{topic.id} data-title=#{topic.title} data-type='topic'>"
        trs += "<td>#{topic.id}</td>"
        trs += "<td>#{topic.title}</td>"
        trs += '/<tr>'
      trs
