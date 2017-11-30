# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

SupportArticle.create [
                          {
                              title: 'Returns policy',
                              category: 1,
                              description: 'Update this.',
                              body: 'Create the returns policy here. You may use markdown.'
                          },
                          {
                              title: 'Terms of use',
                              category: 1,
                              description: 'Update this.',
                              body: 'Create the terms of use here. You may use markdown.'
                          },
                          {
                              title: 'Privacy policy',
                              category: 1,
                              description: 'Update this.',
                              body: 'Create the privacy policy here. You may use markdown.'
                          },
                          {
                              title: 'Security policy',
                              category: 1,
                              description: 'Update this.',
                              body: 'Create the security outline here. You may use markdown.'
                          },
                      ]