# 如何安装一个模板

*****************

##创建模板的步骤

###1.用Webzip软件把要创建的模板下载下来

  在Webzip中打开模板首页，选择菜单"Download"->"Save page +"->"All pages up to 2 links deep from this page(Stay within site)"

###2.用public/themes/generate_new_theme_folder.rb生成空模板文件结构

    generate_new_theme_folder.rb -e theme_name

###3.下载预览图片并保存为: /public/themes/theme_name/preview.jpg

  这个路径将被程序自动识别，请保证图片名称为preview.jpg而不是preview.png or others.

###4.分别保存文件到各个文件夹

###5.添加特殊文件：

  pages/blog.html和pages/post.html
  这两个文件是必须加入的，而且创建网站时候将自动调用。

###6.需要集成的动态项目：

*blog list
*post
*comment form
*duoshuo_place
*site title

**************************

##模板结构说明

     # |theme_name
     #        |assets
     #              _footer.html
     #              _header.html
     #              _index_content.html
     #              css_urls.txt
     #              js_urls.txt
     #        |css
     #        |js
     #        |img
     #        |pages
     #            |blog.html
     #            |post.html
     #        |demo.default.html 


##各个文件说明：

*theme_name

  theme名字必须跟表themes.name一致,     如‘clean_canvas'

*css_urls.txt

  包含theme的css文件，除了font-amazon是公有的(在s.html中自动引入)，其他css文件都是独有的，包括bootstrap.

*js_urls.txt

  包含theme的js文件，不用包含jquery

  公有js：

    <%= javascript_include_tag "jquery", "jquery.turbolinks" %>
    <%= javascript_include_tag "turbolinks" %>

*_header.html

公共页头内容部分，其中要主意的是导航文件的路径，改为如：/p/blog, /p/about

*_footer.html 

统计代码放这里。
另：网站的留言模板comment不能在_footer.html中引用，因为其属于site_page页面引用范围。

*_index_content.html

网站首页内容展现部分， 图片的路径不用手动更改，在create site的时候会有个魔法替换。

*pages

该目录下存放创建网站时候，自动添加的页面，跟theme.default_pages有关。文件的命名请参考site.rb中PAGE_TITLE_HASH.
如： '关于我们' => 'about'， 即文件about.html将对应页面‘关于我们’.

#工具使用

*generate_new_theme_folder.rb

  创建一个空的模板文件夹结构，如:
  generate_new_theme_folder.rb -e theme_name

*demo_create.rb

  按照模板demo.default.html组装一个预览版本。


#注意事项：

  * form 不能加到site.footer里面，要保存哦：can't find nil.id
  
  * 各个theme里面必须包含自己的bootstrap.css（由于版本问题，所以各个模板特有）
    但是不用包含jquery.js 和 bootstrap.js (s.html文件中自动包含了， 因为jquery需要被rails调用才能有rails的神奇功能)

*****************************

网站采用的Liquid语言进行模板渲染，使用到的变量如下：
    
      'site' => 网站, 
      'page' => 页面,
      'posts' => 博客列表,  
      'post' => 博客文章, 
      'comment' => 留言评论, 
      'authenticity_token' => 表单验证, 
      'redirect_url' => 表单跳转地址 

# 网站

    {{ site.title }}                      网站名称
    {{ site.contact_name }}               联系人
    {{ site.mobile_phone }}               手机号码
    {{ site.tel_phone }}                  电话号码
    {{ site.qq }}                          QQ
    {{ site.email }}                       电子邮箱
    {{ site.website }}                     网站地址
    {{ site.address }}                     公司地址
    {{ site.company_name }}                公司名称
    {{ site.duoshuo_place }}               多说评论
    {{ site.recent_posts }}                5条最新发布的文章列表


# 页面

    {{ page.id }}           页面ID, 如：33
    {{ page.short_id }}     页面标示, 如：about
    {{ page.title }}        页面标题, 如：关于我们
    {{ page.content }}      页面内容

    {{ page.content|strip_html|truncate 20 }}的解释：
    去掉html标签，截取内容只保留前20个字符。


# 博客文章列表：

    {% paginate site.site_posts by 3 %}
      {% for post in posts %} 

        {{ post.id }}...

      {% endfor %}
      {{ paginate | default_pagination}}
    {% endpaginate %}


#博客文章

    {{ post.id }}               博客ID
    {{ post.title }}            博客标题
    {{ post.content }}          博客内容
    {{ post.key_words }}        关键词
    {{ post.updated_at }}       更新时间

    {{post.content | html_safe}}

#表单的模板代码

    {% form comment %}
      <input name="authenticity_token" type="hidden" value="{{ authenticity_token }}" />
      <input name="site_comment[site_id]" type="hidden" value="{{ site.id }}" />
      <input name="site_comment[redirect_url]" type="hidden" value="{{ redirect_url }}" />

      {% if form.posted_successfully? %}
        <div class="notice">留言成功，我们会尽快与您取得联系.</div>
      {% endif %}

      {% if form.errors %}
        <div class="notice error">留言失败，请检查是否输入有误!</div>
      {% endif %}

      <input type="text" id="comment_name" name="site_comment[name]" size="40" value="{{form.name}}" class="form-control input-lg {% if form.errors contains 'name' %}input-error{% endif %}" />

      <input type="text" id="comment_mobile_phone" name="site_comment[mobile_phone]" size="40" value="{{form.mobile_phone}}" class="form-control input-lg {% if form.errors contains 'name' %}input-error{% endif %}" />

      <input type="text" id="comment_email" name="site_comment[email]" size="40" value="{{form.email}}" class="{% if form.errors contains 'email' %}input-error{% endif %}" />
                     
      <textarea id="comment_content" name="site_comment[content]" cols="40" rows="5" class="form-control input-lg {% if form.errors contains 'content' %}input-error{% endif %}">{{form.content}}</textarea>

      <button type="submit" class="btn btn-green btn-lg">提交</button>
      <button type="reset" class="btn btn-green btn-lg">重置</button>

    {% endform %}


