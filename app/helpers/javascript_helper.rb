# typed: false
# :reek:DataClump
module JavascriptHelper
  METHODS = {
    update: "html",
    replace: "replaceWith",
    append: "append"
  }.freeze

  def update(selector, args = {})
    wrap(:update, selector, args)
  end

  def replace(selector, args = {})
    wrap(:replace, selector, args)
  end

  def prepend(selector, args = {})
    html = args[:html] || j(render(args))
    "$('#{html}').prependTo('#{selector}');".html_safe
  end

  def append(selector, args = {})
    wrap(:append, selector, args)
  end

  def remove(selector)
    "$('#{selector}').remove();"
  end

  def show(selector)
    "$('#{selector}').show();"
  end

  def hide(selector)
    "$('#{selector}').hide();"
  end

  def empty(selector)
    "$('#{selector}').html('');"
  end

  def show_toolbox
    <<-EOF
    $('#toolbox').addClass('active');
    setTimeout(function() {
       $('#toolbox').find('input[type=text],textarea').filter(':visible:first').focus();
     }, 100);
    EOF
  end

  def hide_toolbox
    "$('#toolbox').removeClass('active');"
  end

  def notification(type, partial, message)
    j render(partial: "shared/notifications/#{type}/#{partial}", locals: {message: message})
  end

  def flash_note(selector, type, partial)
    html = notification(type, partial, flash[:notice])
    res = append selector, html: html
    res << fade_out("#{selector} .#{type}")
  end

  def fade_out(selector, delay = 1000)
    <<-EOF
      setTimeout(function() {
      $('#{selector}').fadeOut(#{delay});
      }, 2000);
    EOF
      .html_safe
  end

  private

  def wrap(method, selector, args)
    html = args[:html] || j(render(args))
    meth = METHODS[method]
    "$('#{selector}').#{meth}('#{html}');".html_safe
  end
end
