# encoding: utf-8
# frozen_string_literal: true
#
# Redmine plugin for Document Management System "Features"
#
# Copyright © 2011    Vít Jonáš <vit.jonas@gmail.com>
# Copyright © 2012    Daniel Munn <dan.munn@munnster.co.uk>
# Copyright © 2011-20 Karel Pičman <karel.picman@kontron.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

module RedmineDmsf
  module Patches
    module QueriesHelperPatch

      ##################################################################################################################
      # Overridden methods

      def column_value(column, item, value)
        case column.name
        when :title
          case item.type
          when 'DmsfFile', 'DmsfFileLink'
            h(value) + content_tag('div', item.filename, class: 'dmsf_filename', title: l(:title_filename_for_download))
          else
            h(value)
          end
        when :size
          number_to_human_size(value)
        else
          super column, item, value
        end
      end

    end
  end
end

RedmineExtensions::PatchManager.register_helper_patch 'QueriesHelper',
  'RedmineDmsf::Patches::QueriesHelperPatch', prepend: true