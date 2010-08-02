Feature: Routes
  Scenario: Routes
    Given the routes are loaded
    Then the following routes should be recognized:
      | method | path                                      | controller          | action  | params                                              |

      # adva-blog
      | GET    | /blogs/1                                  | blogs               | show    | id: 1                                               |
      | GET    | /blogs/1/2009                             | blogs               | show    | id: 1, year: 2009                                   |
      | GET    | /blogs/1/2009/1                           | blogs               | show    | id: 1, year: 2009, month: 1                         |
      | GET    | /blogs/1/2009/1/1                         | blogs               | show    | id: 1, year: 2009, month: 1, day: 1                 |
      | GET    | /blogs/1/2009/1/1/foo                     | posts               | show    | blog_id: 1, year: 2009, month: 1, day: 1, slug: foo |

      | GET    | /admin/sites/1/blogs/1/posts              | admin/posts         | index   | site_id: 1, blog_id: 1                              |
      | POST   | /admin/sites/1/blogs/1/posts              | admin/posts         | create  | site_id: 1, blog_id: 1                              |
      | GET    | /admin/sites/1/blogs/1/posts/new          | admin/posts         | new     | site_id: 1, blog_id: 1                              |
      | GET    | /admin/sites/1/blogs/1/posts/1            | admin/posts         | show    | site_id: 1, blog_id: 1, id: 1                       |
      | PUT    | /admin/sites/1/blogs/1/posts/1            | admin/posts         | update  | site_id: 1, blog_id: 1, id: 1                       |
      | DELETE | /admin/sites/1/blogs/1/posts/1            | admin/posts         | destroy | site_id: 1, blog_id: 1, id: 1                       |
      | GET    | /admin/sites/1/blogs/1/posts/1/edit       | admin/posts         | edit    | site_id: 1, blog_id: 1, id: 1                       |

      # adva-cart
      | POST   | /cart/items                               | cart_items          | create  |                                                     |
      | PUT    | /cart/items/1                             | cart_items          | update  | id: 1                                               |
      | DELETE | /cart/items/1                             | cart_items          | destroy | id: 1                                               |
      | GET    | /cart                                     | cart                | show    |                                                     |

      # adva-catalog
      | GET    | /catalogs/1/products/foo                  | products            | show    | catalog_id: 1, slug: foo                            |
      | GET    | /admin/sites/1/catalogs/1/products        | admin/products      | index   | site_id: 1, catalog_id: 1                           |
      | POST   | /admin/sites/1/catalogs/1/products        | admin/products      | create  | site_id: 1, catalog_id: 1                           |
      | GET    | /admin/sites/1/catalogs/1/products/new    | admin/products      | new     | site_id: 1, catalog_id: 1                           |
      | GET    | /admin/sites/1/catalogs/1/products/1      | admin/products      | show    | site_id: 1, catalog_id: 1, id: 1                    |
      | PUT    | /admin/sites/1/catalogs/1/products/1      | admin/products      | update  | site_id: 1, catalog_id: 1, id: 1                    |
      | DELETE | /admin/sites/1/catalogs/1/products/1      | admin/products      | destroy | site_id: 1, catalog_id: 1, id: 1                    |
      | GET    | /admin/sites/1/catalogs/1/products/1/edit | admin/products      | edit    | site_id: 1, catalog_id: 1, id: 1                    |

      # adva-core
      | POST   | /installations                            | installations       | create  |                                                     |
      | GET    | /installations/new                        | installations       | new     |                                                     |
      | GET    | /pages/1                                  | pages               | show    | id: 1                                               |
      | GET    | /pages/1/article                          | articles            | show    | page_id: 1                                          |

      | GET    | /admin/sites                              | admin/sites         | index   |                                                     |
      | POST   | /admin/sites                              | admin/sites         | create  |                                                     |
      | GET    | /admin/sites/new                          | admin/sites         | new     |                                                     |
      | GET    | /admin/sites/1                            | admin/sites         | show    | id: 1                                               |
      | PUT    | /admin/sites/1                            | admin/sites         | update  | id: 1                                               |
      | DELETE | /admin/sites/1                            | admin/sites         | destroy | id: 1                                               |
      | GET    | /admin/sites/1/edit                       | admin/sites         | edit    | id: 1                                               |

      | GET    | /admin/sites/1/sections                   | admin/sections      | index   | site_id: 1                                          |
      | POST   | /admin/sites/1/sections                   | admin/sections      | create  | site_id: 1                                          |
      | GET    | /admin/sites/1/sections/new               | admin/sections      | new     | site_id: 1                                          |

      | GET    | /admin/sites/1/pages/1/article            | admin/articles      | show    | site_id: 1, page_id: 1                              |
      | POST   | /admin/sites/1/pages/1/article            | admin/articles      | create  | site_id: 1, page_id: 1                              |
      | GET    | /admin/sites/1/pages/1/article/new        | admin/articles      | new     | site_id: 1, page_id: 1                              |
      | PUT    | /admin/sites/1/pages/1/article            | admin/articles      | update  | site_id: 1, page_id: 1                              |
      | DELETE | /admin/sites/1/pages/1/article            | admin/articles      | destroy | site_id: 1, page_id: 1                              |
      | GET    | /admin/sites/1/pages/1/article/edit       | admin/articles      | edit    | site_id: 1, page_id: 1                              |

      # adva-user
      | POST   | /users                                    | admin/registrations | create  |                                                     |
      | PUT    | /users                                    | admin/registrations | update  |                                                     |
      | DELETE | /users                                    | admin/registrations | destroy |                                                     |
      | GET    | /users/sign_up                            | admin/registrations | new     |                                                     |
      | GET    | /users/edit                               | admin/registrations | edit    |                                                     |
