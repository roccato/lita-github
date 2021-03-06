# -*- coding: UTF-8 -*-
#
# Copyright 2014 PagerDuty, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'spec_helper'

describe LitaGithub::R do
  describe '::A_REG' do
    subject { Regexp.new(LitaGithub::R::A_REG) }

    context 'it should match' do
      it 'gh ' do
        expect(subject.match('gh ')).to_not be_nil
      end

      it 'github ' do
        expect(subject.match('github ')).to_not be_nil
      end
    end

    context 'it should not match' do
      it 'gh' do
        expect(subject.match('gh')).to be_nil
      end

      it 'github' do
        expect(subject.match('github')).to be_nil
      end
    end
  end

  describe '::OPT_REGEX' do
    subject { LitaGithub::R::OPT_REGEX }

    context 'it should match' do
      it 'test:pass' do
        s = ' test:pass'
        m = s.scan(subject).flatten.map(&:strip)
        expect(m).to eql ['test:pass']
      end

      it 'test7_pass:pAss_test' do
        s = ' test7_pass:pAss_test'
        m = s.scan(subject).flatten.map(&:strip)
        expect(m).to eql ['test7_pass:pAss_test']
      end

      it 'test:pass bacon:always test:coverage' do
        s = ' test:pass bacon:always test:coverage'
        m = s.scan(subject).flatten.map(&:strip)
        expect(m).to eql ['test:pass', 'bacon:always', 'test:coverage']
      end

      it 'testing:"hi" test:"hello there"' do
        s = ' testing:"hi" test:"hello there"'
        m = s.scan(subject).flatten.map(&:strip)
        expect(m).to eql ['testing:"hi"', 'test:"hello there"']
      end

      it "testing:'hello' test:'what is up?'" do
        s = " testing:'hello' test:'what is up?'"
        m = s.scan(subject).flatten.map(&:strip)
        expect(m).to eql ["testing:'hello'", "test:'what is up?'"]
      end
    end

    context 'it should not match' do
      it 'test-stuff:fail' do
        s = ' test-stuff:fail'
        m = s.scan(subject).flatten
        expect(m).to be_empty
      end

      it 'test: fail' do
        s = ' test: fail'
        m = s.scan(subject).flatten
        expect(m).to be_empty
      end

      it 'test:fail (no leading space)' do
        s = 'test:fail'
        m = s.scan(subject).flatten
        expect(m).to be_empty
      end
    end
  end

  describe '::REPO_REGEX' do
    subject { Regexp.new(LitaGithub::R::REPO_REGEX) }

    context 'it should match' do
      it 'PagerDuty/lita-github' do
        expect(subject.match('PagerDuty/lita-github')).to_not be_nil
      end

      it 'lita-github' do
        expect(subject.match('lita-github')).to_not be_nil
      end

      it 'PagerDuty /lita-github' do
        expect(subject.match('PagerDuty /lita-github')).to_not be_nil
      end

      it 'PagerDuty/ lita-github' do
        expect(subject.match('PagerDuty/ lita-github')).to_not be_nil
      end
    end
  end
end
