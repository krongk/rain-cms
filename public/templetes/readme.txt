# 如何安装一个模板

*****************

##创建模板的步骤

###1.用Webzip软件把要创建的模板下载下来

  在Webzip中打开模板首页，选择菜单"Download"->"Save page +"->"All pages up to 2 links deep from this page(Stay within site)"

###初始化菜单

TRUNCATE TABLE admin_channels;
TRUNCATE TABLE admin_pages;
TRUNCATE TABLE taggings;
TRUNCATE TABLE tags;
INSERT INTO admin_channels(parent_id, typo, title, short_title, properties, default_url, tmp_index, tmp_detail, keywords, description)
VALUES(NULL, 'article', '首页', 'index', 1, NULL, 'temp_index.html', '', '首页', '首页');
INSERT INTO admin_channels(parent_id, typo, title, short_title, properties, default_url, tmp_index, tmp_detail, keywords, description)
VALUES(NULL, 'article', '产品特点', 'features', 1, NULL, 'temp_defult_index.html', 'temp_default_detail.html', '产品特点', '产品特点');
INSERT INTO admin_channels(parent_id, typo, title, short_title, properties, default_url, tmp_index, tmp_detail, keywords, description)
VALUES(NULL, 'article', '模板库', 'portfolio', 1, NULL, 'temp_portfolio_list.html', 'temp_portfolio_detail.html', '模板库', '模板库');
INSERT INTO admin_channels(parent_id, typo, title, short_title, properties, default_url, tmp_index, tmp_detail, keywords, description)
VALUES(NULL, 'article', '博客', 'blog', 1, NULL, 'temp_blog_list.html', 'temp_blog_detail.html', '博客', '博客');
INSERT INTO admin_channels(parent_id, typo, title, short_title, properties, default_url, tmp_index, tmp_detail, keywords, description)
VALUES(NULL, 'article', '联系我们', 'contact', 1, NULL, 'temp_defult_index.html', 'temp_default_detail.html', '联系我们', '联系我们');

INSERT INTO admin_channels(parent_id, typo, title, short_title, properties, default_url, tmp_index, tmp_detail, keywords, description)
VALUES(4, 'article', '产品教程', 'news', 1, NULL, 'temp_blog_list.html', 'temp_blog_detail.html', '产品教程', '产品教程');
INSERT INTO admin_channels(parent_id, typo, title, short_title, properties, default_url, tmp_index, tmp_detail, keywords, description)
VALUES(4, 'article', '开发博客', 'development', 1, NULL, 'temp_blog_list.html', 'temp_blog_detail.html', '开发博客', '开发博客');